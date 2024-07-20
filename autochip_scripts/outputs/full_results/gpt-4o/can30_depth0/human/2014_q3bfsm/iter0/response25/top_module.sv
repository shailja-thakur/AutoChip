module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;
    reg [2:0] next_state;

    // State encoding
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;

    // State transition
    always @(*) begin
        // Default assignments to avoid inferred latches
        next_state = state;
        z = 0; 

        case (state)
            S0: begin
                if (x == 1)
                    next_state = S1;
                else
                    next_state = S0;
                z = 0;
            end
            S1: begin
                if (x == 1)
                    next_state = S4;
                else
                    next_state = S1;
                z = 0;
            end
            S2: begin
                if (x == 1)
                    next_state = S1;
                else
                    next_state = S2;
                z = 0;
            end
            S3: begin
                if (x == 1)
                    next_state = S2;
                else
                    next_state = S1;
                z = 1;
            end
            S4: begin
                if (x == 1)
                    next_state = S4;
                else
                    next_state = S3;
                z = 1;
            end
            default: next_state = S0; // Default safe state
        endcase
    end

    // State updates
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

endmodule
