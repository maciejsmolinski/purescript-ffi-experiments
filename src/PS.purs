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

template :: forall eff. Eff (dom :: DOM | eff) Element
template = do
  doc <- htmlDocumentToDocument <$> (window >>= document)
  div <- createElement "div" doc
  _ <- setClassName "notification is-info" div
  pure div

render :: forall eff. String -> Eff (dom :: DOM | eff) Unit
render text = do
  element <- map elementToNode <$> target
  maybe (pure unit) (setTextContent text) element

append :: forall eff. String -> Eff (dom :: DOM | eff) Unit
append text = do
  container' <- map elementToNode <$> container
  maybe (pure unit) id (cloneAndAppend <$> container')
  where
    cloneAndAppend :: Node -> Eff (dom :: DOM | eff) Unit
    cloneAndAppend target = do
        newElement <- map elementToNode template
        _ <- setTextContent text newElement
        _ <- appendChild newElement target
        pure unit