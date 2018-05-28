module PS (render, append, module DOM) where

import Control.Applicative (map, pure, (<$>), (<*>))
import Control.Monad (bind, (>>=))
import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToParentNode)
import DOM.HTML.Window (document)
import DOM.Node.Node (appendChild, clone, setTextContent)
import DOM.Node.ParentNode (QuerySelector(..), querySelector)
import DOM.Node.Types (Element, Node, elementToNode)
import Data.Function (id, ($))
import Data.Maybe (Maybe, maybe)
import Data.Unit (Unit, unit)

query :: forall eff. QuerySelector -> Eff (dom :: DOM | eff) (Maybe Element)
query selector = do
  doc <- htmlDocumentToParentNode <$> (window >>= document)
  querySelector selector doc

target :: forall eff. Eff (dom :: DOM | eff) (Maybe Element)
target = query $ QuerySelector ".ps-purs-dom"

container :: forall eff. Eff (dom :: DOM | eff) (Maybe Element)
container = query $ QuerySelector ".content"

render :: forall eff. String -> Eff (dom :: DOM | eff) Unit
render text = do
  element <- map elementToNode <$> target
  maybe (pure unit) (setTextContent text) element

append :: forall eff. String -> Eff (dom :: DOM | eff) Unit
append text = do
  target' <- map elementToNode <$> target
  container' <- map elementToNode <$> container
  maybe (pure unit) id (cloneAndAppend <$> target' <*> container')
  where
    cloneAndAppend :: Node -> Node -> Eff (dom :: DOM | eff) Unit
    cloneAndAppend element target = do
        newElement <- clone element
        _ <- setTextContent text newElement
        _ <- appendChild newElement target
        pure unit