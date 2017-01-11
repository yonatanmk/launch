import React, { Component } from 'react';
import Question from './Question';

class QuestionList extends Component {
  constructor(props) {
    super(props)
    this.state = {
      selectedQuestionId: null,
      questions: null
    }
  }

  handleButtonClick(questionId) {
    let newId = questionId;
    if (newId === this.state.selectedQuestionId) {
      newId = null;
    }
    this.setState({ selectedQuestionId: newId });
  }

  componentDidMount() {
    fetch('http://localhost:3000/api/v1/questions'
      ).then(response => {
        return response.json();
      }).then(body => {
        let newQuestions = body;
        this.setState({ questions: newQuestions });
      });
  }

  render() {
    let questionsFragment = null;
    if (this.state.questions !== null) {
      questionsFragment = this.state.questions.map(question => {
        let onButtonClick = () => this.handleButtonClick(question.id);
        let selected = false;
        if (question.id === this.state.selectedQuestionId) {
          selected = true;
        }

        return (
          <Question
            key = {question.id}
            question = {question.question}
            answer = {question.answer}
            handleClick = {onButtonClick}
            selected = {selected}
          />
        )
      })
    }

    return(
      <div className="small-12">
        {questionsFragment}
      </div>
    )
  }
}

export default QuestionList;
