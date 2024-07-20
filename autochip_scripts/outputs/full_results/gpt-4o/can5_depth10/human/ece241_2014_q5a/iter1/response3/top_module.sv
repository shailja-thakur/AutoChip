module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        ZERO = 2'b00,
        ONE = 2'b01,
        COMP = 2'b10
    } state_t;
    
    reg [1:0] state, next_state;
    reg carry;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= ZERO;
        else
            state <= next_state;
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            carry <= 1'b1;
        else if (state == ZERO && x) 
            carry <= 1'b0;
    end

    always @(*) begin
        case (state)
            ZERO: begin
                z = x;
                if (x) begin
                    next_state = COMP;
                end else begin
                    next_state = ZERO;
                end
            end
            COMP: begin
                z = ~x + carry;
                carry = ~x + carry;
                next_state = COMP;
            end
            default: begin
                z = 0;
                next_state = ZERO;
            end
        endcase
    end
endmodule
