module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
reg z_out;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;  // reset to state A
    end else begin
        case (state)
            3'b000:  // state A
                if (w) begin
                    state <= 3'b000;  // transition to state A
                end else begin
                    state <= 3'b001;  // transition to state B
                end
            3'b001:  // state B
                if (w) begin
                    state <= 3'b011;  // transition to state D
                end else begin
                    state <= 3'b010;  // transition to state C
                end
            3'b010:  // state C
                if (w) begin
                    state <= 3'b011;  // transition to state D
                end else begin
                    state <= 3'b100;  // transition to state E
                end
            3'b011:  // state D
                if (w) begin
                    state <= 3'b000;  // transition to state A
                end else begin
                    state <= 3'b101;  // transition to state F
                end
            3'b100:  // state E
                if (w) begin
                    state <= 3'b011;  // transition to state D
                end else begin
                    state <= 3'b100;  // transition to state E
                end
            3'b101:  // state F
                if (w) begin
                    state <= 3'b011;  // transition to state D
                end else begin
                    state <= 3'b010;  // transition to state C
                end
        endcase
    end
end

always @(state) begin
    if (state == 3'b100 || state == 3'b101) begin
        z_out <= 1'b1;   // output z is high when in state E or F
    end else begin
        z_out <= 1'b0;   // output z is low otherwise
    end
end

assign z = z_out;

endmodule
