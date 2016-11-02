package component.simple;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.NumberInputView;
import component.complex.ComplexEasingId;
import core.GlobalCommand;
import core.GlobalContext;
import core.easing.EasingCommand;
import tweenxcore.expr.PolylineKind;
import tweenxcore.geom.Point;

class PolylineView extends ReactComponentOfProps<PolylineProps>
{
	public function new(props:PolylineProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent
	{
		return "div".createElement(
			{
				className: "param-group"
			}, 
			[
				for (i in 0...props.controls.length)
				{
					"div".createElement(
						{
							className: "control-point"
						},
						[
							NumberInputView.createElement(
								{
									name: Std.string(i),
									value: props.controls[i],
									id: props.id.numberInputId(i),
									context: props.context
								}
							),
							"button".createElement(
								{
									className: "btn btn-primary btn-sm",
									onClick: add.bind(i),
								},
								"span".createElement(
									{ className: "glyphicon glyphicon-plus" }
								)
							),
							if (0 < i && i < props.controls.length - 1)
							{
								"button".createElement(
									{
										className: "btn btn-primary btn-sm",
										onClick: remove.bind(i),
									},
									"span".createElement(
										{ className: "glyphicon glyphicon-minus" }
									)
								);
							} else null,
						]
					);
				}
			]
		);
	}
	
	private function add(index:Int):Void
	{
		apply(EasingCommand.AddRate(index));
	}
	
	private function remove(index:Int):Void
	{
		apply(EasingCommand.RemoveRate(index));
	}
	
	private function apply(command:EasingCommand):Void
	{
		props.context.apply(GlobalCommand.ChangeEasing(props.id, command));
	}
}

typedef PolylineProps = 
{
	polyline: PolylineKind,
	controls: Array<Float>,
	id: ComplexEasingId,
	context: GlobalContext
}