module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S_INIT = 2'b00,  // Initial state
        S_INVERT = 2'b01 // Invert bits state
    } state_type;
    
    reg [1:0] state, next_state;
    reg bit_flip; // To determine if we start inverting bits

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_INIT;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_INIT: begin
                next_state = S_INVERT;
            end
            S_INVERT: begin
                next_state = S_INVERT;
            end
            default: begin
                next_state = S_INIT;
            end
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
            bit_flip <= 0;
        end else begin
            if (state == S_INIT) begin
                if (x == 1)
                    bit_flip <= 1;
                z <= bit_flip;
            end else if (state == S_INVERT) begin
                if (bit_flip)
                    z <= ~x;
                else
                    z <= x;
            end
        end
    end
    
endmodule
