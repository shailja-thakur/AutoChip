module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,         // Initial state before the reset is released
        INVERT_BITS = 2'b01,  // State to invert the bits
        ADD_ONE = 2'b10       // State to add one to the inverted bit sequence
    } state_t;
    
    // Current state and next state variables
    state_t state, next_state;
    
    // Bit-flip flag and carry
    reg bit_flip;
    reg carry;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        // Default assignments
        next_state = state;  
        z = 0;              
        
        case (state)
            IDLE: begin
                if (!areset) begin
                    next_state = INVERT_BITS;
                    carry = 1;
                end
            end
            
            INVERT_BITS: begin
                z = ~x;   
                next_state = ADD_ONE;
            end
            
            ADD_ONE: begin
                z = z + carry;  // Add carry to the inverted bit
                if (carry) begin
                    carry = 0;
                end
                next_state = INVERT_BITS;
            end
            
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            bit_flip <= 0;
            carry <= 0;
        end else begin
            bit_flip <= next_state == ADD_ONE ? bit_flip : ~bit_flip;
        end
    end

endmodule
