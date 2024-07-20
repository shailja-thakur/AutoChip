module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;  // initial state is A
    else begin
        case (state)
            3'b000: begin  // A
                if (w)
                    state <= 3'b001;  // next state is B
                else
                    state <= 3'b000;  // next state is A
            end
            3'b001: begin  // B
                if (w)
                    state <= 3'b010;  // next state is C
                else
                    state <= 3'b010;  // next state is D
            end
            3'b010: begin  // C
                if (w)
                    state <= 3'b100;  // next state is E
                else
                    state <= 3'b010;  // next state is D
            end
            3'b011: begin  // D
                if (w)
                    state <= 3'b111;  // next state is F
                else
                    state <= 3'b000;  // next state is A
            end
            3'b100: begin  // E
                if (w)
                    state <= 3'b100;  // next state is E
                else
                    state <= 3'b010;  // next state is D
            end
            3'b111: begin  // F
                if (w)
                    state <= 3'b010;  // next state is C
                else
                    state <= 3'b111;  // next state is F
            end
        endcase
    end
end

assign z = (state == 3'b100) || (state == 3'b111);

endmodule
