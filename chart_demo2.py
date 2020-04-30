#https://stackoverflow.com/questions/50728328/python-how-to-show-matplotlib-in-flask
#anaconda prompt : python chart_demo.py
#http://127.0.0.1:5000/plot.png

import io
import random
from flask import Response
from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
from matplotlib.figure import Figure
import numpy as np
import matplotlib.pyplot as plt

from flask import Flask
app = Flask(__name__)

@app.route('/plot.png')
def plot_png():
    fig = create_figure()
    output = io.BytesIO()
    FigureCanvas(fig).print_png(output)
    return Response(output.getvalue(), mimetype='image/png')

def create_figure():
    '''
    fig = Figure()
    axis = fig.add_subplot(1, 1, 1)
    objects = ('Python', 'C++', 'Java', 'Perl', 'Scala', 'Lisp')
    y_pos = np.arange(len(objects))
    performance = [10,8,6,4,2,1]
    axis.bar(y_pos, performance, align='center', alpha=0.5)
    #axis.xticks(y_pos, objects)
    #axis.ylabel('Usage')
    #axis.title('Programming language usage')

    return fig
    '''
    fig = Figure()
    labels = 'Frogs', 'Hogs', 'Dogs', 'Logs'
    sizes = [15, 30, 45, 10]
    explode = (0, 0.1, 0, 0) 

    axis = fig.add_subplot(1, 1, 1)
    axis.pie(sizes, explode=explode, labels=labels, autopct='%1.1f%%',
        shadow=True, startangle=90)
    axis.axis('equal')

    return fig

if __name__ == "__main__":
    app.run()
