module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

// State machine logic
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else begin
        case (state)
            3'b000: begin // A
                if (w == 1'b0)
                    state <= 3'b001; // B
                else
                    state <= 3'b000; // A
            end
            
            3'b001: begin // B
                if (w == 1'b0)
                    state <= 3'b010; // C
                else
                    state <= 3'b011; // D
            end
            
            3'b010: begin // C
                if (w == 1'b0)
                    state <= 3'b100; // E
                else
                    state <= 3'b011; // D
            end
            
            3'b011: begin // D
                if (w == 1'b0)
                    state <= 3'b101; // F
                else
                    state <= 3'b000; // A
            end
            
            3'b100: begin // E
                if (w == 1'b0)
                    state <= 3'b100; // E
                else
                    state <= 3'b011; // D
            end
            
            3'b101: begin // F
                if (w == 1'b0)
                    state <= 3'b010; // C
                else
                    state <= 3'b011; // D
            end
        endcase
    end
end

// Output logic
always @(state) begin
    case (state)
        3'b000: z <= 1'b0; // A
        3'b001: z <= 1'b0; // B
        3'b010: z <= 1'b0; // C
        3'b011: z <= 1'b0; // D
        3'b100: z <= 1'b1; // E
        3'b101: z <= 1'b1; // F
    endcase
end

endmodule
