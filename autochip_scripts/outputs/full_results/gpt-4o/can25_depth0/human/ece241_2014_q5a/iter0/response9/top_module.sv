module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state, next_state;

    // State encoding
    localparam S0 = 2'd0; // Waiting state
    localparam S1 = 2'd1; // Inverting state
    localparam S2 = 2'd2; // Passing state

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            S0: begin
                z = 0; // Initial output
                if (x == 1) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                z = ~x; // Invert X
                next_state = S2;
            end
            S2: begin
                z = x; // Directly pass X
                next_state = S2;
            end
            default: begin
                z = 0; // Default state
                next_state = S0;
            end
        endcase
    end

endmodule
