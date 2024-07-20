module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state; // 3-bit register for state

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // initial state is A
    else begin
        case (state)
            3'b000: begin // state A
                if (w)
                    state <= 3'b001; // transition to B
                else
                    state <= 3'b000; // stay in A
            end
            3'b001: begin // state B
                if (w)
                    state <= 3'b010; // transition to C
                else
                    state <= 3'b100; // transition to D
            end
            3'b010: begin // state C
                if (w)
                    state <= 3'b110; // transition to E
                else
                    state <= 3'b100; // transition to D
            end
            3'b100: begin // state D
                if (w)
                    state <= 3'b011; // transition to F
                else
                    state <= 3'b000; // transition to A
            end
            3'b011: begin // state E
                if (w)
                    state <= 3'b011; // stay in E
                else
                    state <= 3'b100; // transition to D
            end
            3'b110: begin // state F
                if (w)
                    state <= 3'b110; // stay in F
                else
                    state <= 3'b010; // transition to C
            end
        endcase
    end
end

assign z = (state == 3'b011) || (state == 3'b110); // set z to 1 when state is E or F

endmodule
