module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        IDLE = 2'b00,
        INVERT = 2'b01,
        OUTPUT = 2'b10
    } state_type;

    state_type state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            IDLE:
                if (x == 1'b0)
                    next_state = OUTPUT;
                else
                    next_state = INVERT;
            
            INVERT:
                next_state = OUTPUT;
            
            OUTPUT:
                if (areset)
                    next_state = IDLE;
                else
                    next_state = OUTPUT;

            default:
                next_state = IDLE;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            z <= 1'b0;
        else begin
            case (state)
                IDLE:
                    z <= x;
                INVERT:
                    z <= ~x;
                OUTPUT:
                    z <= z;
                default:
                    z <= 1'b0;
            endcase
        end
    end

endmodule
