module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [2:0] count;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 0;
    else begin
        case (state)
            0: if (s) state <= 1;
               else state <= 0;
            1: begin
                 if (w) count <= count + 1;
                 state <= 2;
               end
            2: begin
                 if (w) count <= count + 1;
                 state <= 3;
               end
            3: begin
                 if (w) count <= count + 1;
                 if (count == 2) z <= 1;
                 else z <= 0;
                 state <= 0;
                 count <= 0;
               end
        endcase
    end
end

endmodule
