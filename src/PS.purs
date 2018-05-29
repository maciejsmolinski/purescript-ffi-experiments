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
import DOM.Node.Types (Element, elementToNode)
import Data.Maybe (Maybe, maybe)

query :: forall eff. QuerySelector -> Eff (dom :: DOM | eff) (Maybe Element)
query selector = do
  doc <- htmlDocumentToParentNode <$> (window >>= document)
  querySelector selector doc

withText :: forall eff. String -> Element -> Eff (dom :: DOM  | eff) Element
withText text element = pure element <* setTextContent text (elementToNode element)

withClass :: forall eff. String -> Element -> Eff (dom :: DOM  | eff) Element
withClass classname element = do
  pure element <* setClassName classname element

withElement :: forall eff. QuerySelector -> (Element -> Eff (dom :: DOM | eff) Unit) -> Eff (dom :: DOM | eff) Unit
withElement selector cb = do
  element' <- query selector
  maybe (pure unit) cb element'

withContainer :: forall eff. (Element -> Eff (dom :: DOM | eff) Unit) -> Eff (dom :: DOM | eff) Unit
withContainer = withElement $ QuerySelector ".content"

withTarget :: forall eff. (Element -> Eff (dom :: DOM | eff) Unit) -> Eff (dom :: DOM | eff) Unit
withTarget = withElement $ QuerySelector ".ps-purs-dom"

element :: forall eff. String -> Eff (dom :: DOM | eff) Element
element tag = do
  doc <- htmlDocumentToDocument <$> (window >>= document)
  createElement tag doc

notification :: forall eff. String -> Eff (dom :: DOM | eff) Element
notification text = element "div" >>= withClass "notification is-info" >>= withText text

render :: forall eff. String -> Eff (dom :: DOM | eff) Unit
render text = do
  withTarget \element -> do
     setTextContent text (elementToNode element)

append :: forall eff. String -> Eff (dom :: DOM | eff) Unit
append text = do
  withContainer \element -> do
    notification' <- elementToNode <$> notification text
    appendChild notification' (elementToNode element) *> pure unit