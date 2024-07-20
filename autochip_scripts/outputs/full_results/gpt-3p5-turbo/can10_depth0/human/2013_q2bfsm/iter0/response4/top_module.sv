module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f;
reg g;
reg [1:0] state;
reg [2:0] x_history;
reg y_flag;

always @(posedge clk, negedge resetn)
if (!resetn)
    begin
        state <= 2'b00; // Starting State - A
        f <= 0;
        g <= 0;
        x_history <= 0;
        y_flag <= 0;
    end
    else
    begin
        case (state)
            2'b00:
            begin
                if (resetn == 0)
                    state <= 2'b00; // Stay in Starting State - A
                else
                    state <= 2'b01; // Transition to State B
            end

            2'b01:
            begin
                if (resetn == 0)
                    state <= 2'b00; // Transition to Starting State - A
                else
                begin
                    f <= 1;
                    state <= 2'b10; // Transition to State C
                end
            end

            2'b10:
            begin
                if (resetn == 0)
                    state <= 2'b00; // Transition to Starting State - A
                else if (x_history == 3'b101)
                begin
                    g <= 1;
                    state <= 2'b11; // Transition to State D
                end
                else
                    state <= 2'b10; // Stay in State C
            end

            2'b11:
            begin
                if (resetn == 0)
                    state <= 2'b00; // Transition to Starting State - A
                else if (y == 1)
                begin
                    y_flag <= 1;
                    state <= 2'b11; // Stay in State D
                end
                else if (y_flag == 1)
                begin
                    g <= 1;
                    state <= 2'b11; // Stay in State D
                end
                else
                begin
                    g <= 0;
                    state <= 2'b00; // Transition to Starting State - A
                end
            end
        endcase
    end

assign f = (state == 2'b01) ? 1 : 0;

endmodule
