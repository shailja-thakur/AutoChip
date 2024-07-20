module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
wire z_tmp;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;  // Assign initial value to state on reset
    end else begin
        case ({w, state})
            2'b00: state <= (state == 3'b000) ? 3'b000 : 3'b100;
            2'b01: state <= (state == 3'b000) ? 3'b001 :
                            (state == 3'b001) ? 3'b010 :
                            (state == 3'b011) ? 3'b101 :
                            (state == 3'b100) ? 3'b111 :
                            (state == 3'b101) ? 3'b101 :
                            3'b011;
            2'b10: state <= (state == 3'b001) ? 3'b101 : 3'b011;
            2'b11: state <= (state == 3'b101) ? 3'b101 :
                            (state == 3'b110) ? 3'b011 :
                            3'b110;
        endcase
    end
end

// Output Z logic
assign z_tmp = (state == 3'b101) || (state == 3'b110);
assign z = z_tmp;

endmodule
