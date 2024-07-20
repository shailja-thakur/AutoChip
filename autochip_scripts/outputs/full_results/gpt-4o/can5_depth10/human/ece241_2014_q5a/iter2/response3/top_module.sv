module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        ZERO = 2'b00,
        COMP = 2'b01,
        ONE = 2'b10
    } state_t;
    
    // State and next state variables
    reg [1:0] state, next_state;

    // Output register
    reg z_next;

    // State transition on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= ZERO;
        else
            state <= next_state;
    end

    // Output update on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset)
            z <= 0;
        else
            z <= z_next;
    end

    // Next state logic
    always @(*) begin
        case (state)
            ZERO: begin
                if (x == 1'b1) begin
                    next_state = COMP;
                    z_next = x;
                end else begin
                    next_state = ZERO;
                    z_next = x;
                end
            end
            COMP: begin
                next_state = COMP;
                z_next = ~x;
            end
            default: begin
                next_state = ZERO;
                z_next = 1'b0;
            end
        endcase
    end
endmodule
