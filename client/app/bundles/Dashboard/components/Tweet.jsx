import React, { PropTypes } from 'react'

export default class Tweet extends React.Component {

  renderMediaImage(){
    let entities = this.props.tweet.entities
    if(entities.hasOwnProperty('media')){
      return(
        entities.media.map((image) => {
          return(
            <div key={image.id}>
              <img src={image.media_url_https} className="img-fluid" height={image.sizes.small.h} width={image.sizes.small.w}/>
            </div>
          )
        })
      )
    }
  }

  render(){
    return(
      <div>
        <div className="card">
          <div className="card-header">
            <strong>{'@'}{this.props.tweet.user.screen_name}</strong>
          </div>
          { this.renderMediaImage() }
          <div className="card-block">
            <p className="card-text">{this.props.tweet.text}</p>
          </div>
        </div>
      </div>
    )
  }
}
