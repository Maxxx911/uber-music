import React from 'react';
import {makeStyles} from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardActionArea from '@material-ui/core/CardActionArea';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';

const useStyles = makeStyles({
  card: {
    maxWidth: 345,
    margin: '10px',
  },
  media: {
    height: 140,
  },
});

export default function EventsCard(props) {
  const classes = useStyles();
  return (
    <Card className={classes.card}>
      <CardActionArea>
        <CardMedia
          className={classes.media}
          image={props.image === "" ? "/assets/default_avatar.jpg" : props.image}
          title="Contemplative Reptile"
        />
        <CardContent>
          <Typography gutterBottom variant="h5" component="h2">
            {props.nickname === "" &&
            "No nickname"
            }
            {props.nickname}
          </Typography>
          <Typography variant="body2" color="textSecondary" component="p">
            {props.name === " " &&
            "No name"
            }
            {props.name}
            <br/>
            {props.email}
          </Typography>
        </CardContent>
      </CardActionArea>
      <CardActions>
        <a href={props.link} data-method="get">
          <Button size="small" color="primary">
            Learn More
          </Button>
        </a>
      </CardActions>
    </Card>
  );
}