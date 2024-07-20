module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
wire z;

assign z = (state == 3'b100) || (state == 3'b101);

always@(posedge clk or posedge reset) begin
    if(reset) begin
        state <= 3'b00;
    end else begin
        case({w, state})
            2'b00: state <= 3'b00;
            2'b01: state <= 3'b01;
            2'b10: state <= 3'b10;
            2'b11: state <= 3'b11;
        endcase
    end
end

endmodule
