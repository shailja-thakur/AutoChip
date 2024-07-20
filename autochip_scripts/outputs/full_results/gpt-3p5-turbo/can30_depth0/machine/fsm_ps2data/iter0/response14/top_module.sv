module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [2:0] state;
reg [23:0] register;
wire [2:0] next_state;

assign done = (state == 3'b011);
assign out_bytes = (done) ? register : 24'b0;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b00;
        register <= 24'b0;
    end else begin
        state <= next_state;
        register <= (state == 3'b000) ? {register[15:0], in} : (state == 3'b011) ? {register[7:0], in} : register;
    end
end

assign next_state = (state == 3'b000 && in[2]) ? 3'b001 :
                   (state == 3'b001) ? 3'b010 :
                   (state == 3'b010) ? 3'b011 :
                   (state == 3'b011 && !in[2]) ? 3'b000 :
                   state;

endmodule
