module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [1:0] state;
reg [23:0] message;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 0;
        message <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    state <= 1;
                    message[23:16] <= in;
                end
            end
            1: begin
                state <= 2;
                message[15:8] <= in;
            end
            2: begin
                state <= 3;
                message[7:0] <= in;
            end
            3: state <= 0;
        endcase
    end
end

assign out_bytes = (done) ? message : 0;

assign done = (state == 3);

endmodule
