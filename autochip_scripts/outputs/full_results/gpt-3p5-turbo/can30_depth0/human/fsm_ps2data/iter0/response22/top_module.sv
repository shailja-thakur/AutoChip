module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
); 

reg [23:0] message;
reg [1:0] state;

always @(posedge clk) begin
    if (reset)
        state <= 0;
    else begin
        case (state)
            0: begin
                if (in[3])
                    state <= 1;
            end
            1: begin
                state <= 2;
                message[23:16] <= in;
            end
            2: begin
                state <= 3;
                message[15:8] <= in;
            end
            3: begin
                message[7:0] <= in;
                state <= 0;
            end
        endcase
    end
end

assign done = (state == 3);
assign out_bytes = message;

endmodule
