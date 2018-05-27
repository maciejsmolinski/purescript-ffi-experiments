module PS (render, append, module DOM) where

import Control.Applicative (pure)
import Control.Monad (bind)
import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToDocument)
import DOM.HTML.Window (document)
import DOM.Node.Node (appendChild, clone, setTextContent)
import DOM.Node.ParentNode (QuerySelector(..), querySelector)
import DOM.Node.Types (Element, documentToParentNode, elementToNode)
import Data.Function (($))
import Data.Maybe (Maybe(..))
import Data.Unit (Unit, unit)

query :: forall eff. QuerySelector -> Eff (dom :: DOM | eff) (Maybe Element)
query selector = do
  win <- window
  doc <- document win
  let parent = documentToParentNode $ htmlDocumentToDocument doc
  querySelector selector parent

target :: forall eff. Eff (dom :: DOM | eff) (Maybe Element)
target = query $ QuerySelector ".ps-purs-dom"

container :: forall eff. Eff (dom :: DOM | eff) (Maybe Element)
container = query $ QuerySelector ".content"

render :: forall eff. String -> Eff (dom :: DOM | eff) Unit
render text = do
  element <- target
  case element of
    (Just e) -> setTextContent text $ elementToNode e
    _ -> pure unit

append :: forall eff. String -> Eff (dom :: DOM | eff) Unit
append text = do
  target' <- target
  container' <- container
  case target' of
    (Just t) -> case container' of
      Just (c) -> do
        newTarget <- clone $ elementToNode t
        _ <- setTextContent text newTarget
        _ <- appendChild newTarget (elementToNode c)
        pure unit
      Nothing -> pure unit
    Nothing -> pure unit