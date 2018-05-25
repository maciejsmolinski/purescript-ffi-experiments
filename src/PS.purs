module PS (render, module DOM) where

import Control.Applicative (pure)
import Control.Monad (bind)
import Control.Monad.Eff (Eff)
import Data.Function (($))
import Data.Maybe (Maybe(..))
import Data.Unit (Unit, unit)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToDocument)
import DOM.HTML.Window (document)
import DOM.Node.Node (setTextContent)
import DOM.Node.ParentNode (QuerySelector(..), querySelector)
import DOM.Node.Types (Element, documentToParentNode, elementToNode)

target :: forall eff. Eff (dom :: DOM | eff) (Maybe Element)
target = do
  win <- window
  doc <- document win
  let parent = documentToParentNode $ htmlDocumentToDocument doc
  querySelector (QuerySelector "#ps-purs-dom") parent


render :: forall eff. String -> Eff (dom :: DOM | eff) Unit
render text = do
  element <- target
  case element of
    (Just e) -> setTextContent text $ elementToNode e
    _ -> pure unit