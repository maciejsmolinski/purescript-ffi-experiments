module PS (render, append, module DOM) where

import Prelude

import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToDocument, htmlDocumentToParentNode)
import DOM.HTML.Window (document)
import DOM.Node.Document (createElement)
import DOM.Node.Element (setClassName)
import DOM.Node.Node (appendChild, setTextContent)
import DOM.Node.ParentNode (QuerySelector(..), querySelector)
import DOM.Node.Types (Element, Node, elementToNode)
import Data.Maybe (Maybe, maybe)

query :: forall eff. QuerySelector -> Eff (dom :: DOM | eff) (Maybe Element)
query selector = do
  doc <- htmlDocumentToParentNode <$> (window >>= document)
  querySelector selector doc

target :: forall eff. Eff (dom :: DOM | eff) (Maybe Element)
target = query $ QuerySelector ".ps-purs-dom"

container :: forall eff. Eff (dom :: DOM | eff) (Maybe Element)
container = query $ QuerySelector ".content"

template :: forall eff. String -> Eff (dom :: DOM | eff) Element
template text = do
  doc <- htmlDocumentToDocument <$> (window >>= document)
  div <- createElement "div" doc
  setClassName "notification is-info" div *> setTextContent text (elementToNode div) *> pure div

withText :: forall eff. String -> Element -> Eff (dom :: DOM  | eff) Element
withText text element = pure element <* setTextContent text (elementToNode element)

withClass :: forall eff. String -> Element -> Eff (dom :: DOM  | eff) Element
withClass classname element = do
  pure element <* setClassName classname element

element :: forall eff. String -> Eff (dom :: DOM | eff) Element
element tag = do
  doc <- htmlDocumentToDocument <$> (window >>= document)
  createElement tag doc

notification :: forall eff. String -> Eff (dom :: DOM | eff) Element
notification text = element "div" >>= withClass "notification is-info" >>= withText text

render :: forall eff. String -> Eff (dom :: DOM | eff) Unit
render text = do
  element <- map elementToNode <$> target
  maybe (pure unit) (setTextContent text) element

append :: forall eff. String -> Eff (dom :: DOM | eff) Unit
append text = do
  container' <- map elementToNode <$> container
  maybe (pure unit) id (appendFromTemplate <$> container')
  where
    appendFromTemplate :: Node -> Eff (dom :: DOM | eff) Unit
    appendFromTemplate target = do
        template'' <- elementToNode <$> notification text
        appendChild template'' target *> pure unit