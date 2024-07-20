module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        IDLE = 2'b00,
        COMP = 2'b01
    } state_t;
    
    reg [1:0] state, next_state;
    reg carry;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
            carry <= 1'b1;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (areset) 
                    next_state = IDLE;
                else
                    next_state = COMP;
            end
            COMP: begin
                next_state = COMP;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
        end
        else begin
            if (state == IDLE) begin
                carry <= 1'b1;
                z <= x;
            end
            else if (state == COMP) begin
                z <= ~x + carry;
                // Calculate next carry for future iterations
                carry <= (~x & carry) | z;
            end
        end
    end
endmodule
