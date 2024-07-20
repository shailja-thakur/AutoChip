module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state; // 3-bit state register

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000; // initial state is A
    end
    else begin
        case (state)
            3'b000: begin // state A
                if (w) begin
                    state <= 3'b000; // transition to A
                end
                else begin
                    state <= 3'b001; // transition to B
                end
            end
            3'b001: begin // state B
                if (w) begin
                    state <= 3'b011; // transition to D
                end
                else begin
                    state <= 3'b010; // transition to C
                end
            end
            3'b010: begin // state C
                if (w) begin
                    state <= 3'b011; // transition to D
                end
                else begin
                    state <= 3'b100; // transition to E
                end
            end
            3'b011: begin // state D
                if (w) begin
                    state <= 3'b000; // transition to A
                end
                else begin
                    state <= 3'b101; // transition to F
                end
            end
            3'b100: begin // state E
                if (reset) begin
                    state <= 3'b110; // transition to D
                end
                else begin
                    state <= 3'b100; // stay in E
                end
            end
            3'b101: begin // state F
                if (reset) begin
                    state <= 3'b010; // transition to C
                end
                else begin
                    state <= 3'b101; // stay in F
                end
            end
            3'b110: begin // state G
                if (reset) begin
                    state <= 3'b110; // stay in G
                end
                else begin
                    state <= 3'b100; // transition to E
                end
            end
        endcase
    end
end

assign z = (state == 3'b100) ? 1'b1 : 1'b0; // output is 1 when in state E

endmodule
