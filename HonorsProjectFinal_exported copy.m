classdef HonorsProjectFinal_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        GridLayout             matlab.ui.container.GridLayout
        LeftPanel              matlab.ui.container.Panel
        Image2                 matlab.ui.control.Image
        QuantumNumberLabel_2   matlab.ui.control.Label
        QuantumNumberSlider_2  matlab.ui.control.Slider
        SliderLabel_2          matlab.ui.control.Label
        PlotButton             matlab.ui.control.Button
        QuantumNumberSlider    matlab.ui.control.Slider
        SliderLabel            matlab.ui.control.Label
        QuantumNumberLabel     matlab.ui.control.Label
        RightPanel             matlab.ui.container.Panel
        ProbDensGraph          matlab.ui.control.UIAxes
        WavefunctionGraph      matlab.ui.control.UIAxes
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button down function: WavefunctionGraph
        function WavefunctionGraphButtonDown(app, event)
            
        end

        % Button pushed function: PlotButton
        function PlotButtonPushed(app, event)
            N = app.QuantumNumberSlider.Value
            
            x = 0:0.01:2;
            y = (sqrt(2)*(sin(N*pi*x))).^(2);
            plot(app.ProbDensGraph,y,'k');

            N1 = app.QuantumNumberSlider_2.Value
            
            x = 0:0.01:2;
            y = sqrt(2)*(sin(N1*pi*x));
            plot(app.WavefunctionGraph,y,'m');
        end

        % Callback function
        function ClassicalProbabilityDensitySwitchValueChanged(app, event)
            value = app.ClassicalProbabilityDensitySwitch.Value;
            
            y = 0.5
            if strcmp(value,'On')
                plot(app.WavefunctionGraph,y,'r');
            end
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {480, 480};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {234, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {234, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create QuantumNumberLabel
            app.QuantumNumberLabel = uilabel(app.LeftPanel);
            app.QuantumNumberLabel.FontName = 'Bookman';
            app.QuantumNumberLabel.FontWeight = 'bold';
            app.QuantumNumberLabel.Position = [57 286 125 22];
            app.QuantumNumberLabel.Text = 'Quantum Number (n)';

            % Create SliderLabel
            app.SliderLabel = uilabel(app.LeftPanel);
            app.SliderLabel.HorizontalAlignment = 'right';
            app.SliderLabel.FontName = 'Bookman';
            app.SliderLabel.Position = [14 265 25 22];
            app.SliderLabel.Text = '';

            % Create QuantumNumberSlider
            app.QuantumNumberSlider = uislider(app.LeftPanel);
            app.QuantumNumberSlider.Limits = [1 10];
            app.QuantumNumberSlider.MajorTicks = [1 2 3 4 5 6 7 8 9 10];
            app.QuantumNumberSlider.MinorTicks = [1 2 3 4 5 6 7 8 9 10];
            app.QuantumNumberSlider.FontName = 'Bookman';
            app.QuantumNumberSlider.Position = [47 258 145 3];
            app.QuantumNumberSlider.Value = 1;

            % Create PlotButton
            app.PlotButton = uibutton(app.LeftPanel, 'push');
            app.PlotButton.ButtonPushedFcn = createCallbackFcn(app, @PlotButtonPushed, true);
            app.PlotButton.Position = [70 332 100 22];
            app.PlotButton.Text = 'Plot';

            % Create SliderLabel_2
            app.SliderLabel_2 = uilabel(app.LeftPanel);
            app.SliderLabel_2.HorizontalAlignment = 'right';
            app.SliderLabel_2.FontName = 'Bookman';
            app.SliderLabel_2.Position = [4 444 25 22];
            app.SliderLabel_2.Text = '';

            % Create QuantumNumberSlider_2
            app.QuantumNumberSlider_2 = uislider(app.LeftPanel);
            app.QuantumNumberSlider_2.Limits = [1 10];
            app.QuantumNumberSlider_2.MajorTicks = [1 2 3 4 5 6 7 8 9 10];
            app.QuantumNumberSlider_2.MinorTicks = [1 2 3 4 5 6 7 8 9 10];
            app.QuantumNumberSlider_2.FontName = 'Bookman';
            app.QuantumNumberSlider_2.Position = [40 407 145 3];
            app.QuantumNumberSlider_2.Value = 1;

            % Create QuantumNumberLabel_2
            app.QuantumNumberLabel_2 = uilabel(app.LeftPanel);
            app.QuantumNumberLabel_2.FontName = 'Bookman';
            app.QuantumNumberLabel_2.FontWeight = 'bold';
            app.QuantumNumberLabel_2.Position = [57 444 125 22];
            app.QuantumNumberLabel_2.Text = 'Quantum Number (n)';

            % Create Image2
            app.Image2 = uiimage(app.LeftPanel);
            app.Image2.Position = [6 1 222 217];
            app.Image2.ImageSource = fullfile(pathToMLAPP, 'Screen Shot 2022-11-27 at 11.02.19 AM.png');

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create WavefunctionGraph
            app.WavefunctionGraph = uiaxes(app.RightPanel);
            title(app.WavefunctionGraph, 'Wavefunction Ψ_n(x)')
            zlabel(app.WavefunctionGraph, 'Z')
            app.WavefunctionGraph.FontName = 'Bookman';
            app.WavefunctionGraph.XTick = [0 0.2 0.4 0.6 0.8 1];
            app.WavefunctionGraph.XTickLabel = '';
            app.WavefunctionGraph.YTick = [-1 -0.5 0 0.5 1];
            app.WavefunctionGraph.YTickLabel = {'-1'; '-0.5'; '0'; '0.5'; '1'};
            app.WavefunctionGraph.ButtonDownFcn = createCallbackFcn(app, @WavefunctionGraphButtonDown, true);
            app.WavefunctionGraph.Position = [32 260 342 206];

            % Create ProbDensGraph
            app.ProbDensGraph = uiaxes(app.RightPanel);
            title(app.ProbDensGraph, 'Probability Density |Ψ_n(x)|^2')
            xlabel(app.ProbDensGraph, 'Length of the Box')
            zlabel(app.ProbDensGraph, 'Z')
            app.ProbDensGraph.FontName = 'Bookman';
            app.ProbDensGraph.XTick = [0 0.2 0.4 0.6 0.8 1];
            app.ProbDensGraph.XTickLabel = '';
            app.ProbDensGraph.Position = [32 28 342 214];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = HonorsProjectFinal_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end