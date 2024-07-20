module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

    wire [5:0] y_next;
    wire y2, y4;
    
    assign y_next[0] = y[1];
    assign y_next[1] = y[2];
    assign y_next[2] = y[3];
    assign y_next[3] = y[4];
    assign y_next[4] = y[5];
    assign y_next[5] = y[6];

    assign Y2 = y2;
    assign Y4 = y4;

    always @* begin
        case(y_next)
            6'b000001: begin
                y2 = w & ~y[1];
                y4 = w & ~y[3];
            end
            6'b000010: begin
                y2 = w & y[2];
                y4 = w & ~y[4];
            end
            6'b000100: begin
                y2 = w & ~y[2];
                y4 = w & y[4];
            end
            6'b001000: begin
                y2 = w & y[2];
                y4 = w & ~y[4];
            end
            6'b010000: begin
                y2 = w & ~y[2];
                y4 = w & ~y[4];
            end
            6'b100000: begin
                y2 = w & ~y[2];
                y4 = w & y[4];
            end
            default: begin // for all non-defined states, hold
                y2 = 1'b0;
                y4 = 1'b0;
            end
        endcase
    end

endmodule
