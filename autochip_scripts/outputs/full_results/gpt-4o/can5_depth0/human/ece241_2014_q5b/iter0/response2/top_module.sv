module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    reg [1:0] state, next_state;
    localparam A = 2'b01;
    localparam B = 2'b10;
    
    // State transition logic (combinational)
    always @(*) begin
        case(state)
            A: if (x) begin
                 next_state = B;
               end else begin
                 next_state = A;
               end
            B: if (x) begin
                 next_state = B;
               end else begin
                 next_state = B;
               end
            default: next_state = A; // Shouldn't happen
        endcase
    end

    // Output logic (combinational)
    always @(*) begin
        case(state)
            A: z = x ? 1 : 0;
            B: z = x ? 0 : 1;
            default: z = 0; // Shouldn't happen
        endcase
    end

    // State register logic (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // Reset to state A
        end else begin
            state <= next_state;
        end
    end

endmodule
