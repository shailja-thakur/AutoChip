module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        S1 = 2'b00,
        S2 = 2'b01,
        S3 = 2'b10
    } state_t;
    
    state_t current_state, next_state;
    reg carry;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S1;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S1: begin
                if (x == 1'b1)
                    next_state = S2;
                else
                    next_state = S1;
            end
            S2: begin
                next_state = S3;
            end
            S3: begin
                next_state = S3;
            end
            default: next_state = S1;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            carry <= 1'b1;
            z <= 1'b0;
        end else begin
            case (current_state)
                S1: begin
                    z <= x;               // The first bit is passed directly
                end
                S2: begin
                    z <= !x;              // The complement of the first '1' detected
                    carry <= 1'b0;        // Start the complement process
                end
                S3: begin
                    z <= x ^ carry;       // Default XOR behavior for the complement
                    carry <= carry & x;   // Update carry bit
                end
            endcase
        end
    end

endmodule
