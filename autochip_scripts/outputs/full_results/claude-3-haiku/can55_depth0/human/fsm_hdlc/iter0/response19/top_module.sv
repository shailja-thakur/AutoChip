module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;

localparam [2:0]
    IDLE = 3'b000,
    BIT1 = 3'b001,
    BIT2 = 3'b010,
    BIT3 = 3'b011,
    BIT4 = 3'b100,
    BIT5 = 3'b101,
    BIT6 = 3'b110,
    BIT7 = 3'b111;

// State transition logic
always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b0)
                next_state = BIT1;
            else
                next_state = IDLE;
        end
        BIT1: begin
            if (in == 1'b1)
                next_state = BIT2;
            else
                next_state = IDLE;
        end
        BIT2: begin
            if (in == 1'b1)
                next_state = BIT3;
            else
                next_state = IDLE;
        end
        BIT3: begin
            if (in == 1'b1)
                next_state = BIT4;
            else
                next_state = IDLE;
        end
        BIT4: begin
            if (in == 1'b1)
                next_state = BIT5;
            else
                next_state = IDLE;
        end
        BIT5: begin
            if (in == 1'b1)
                next_state = BIT6;
            else
                next_state = IDLE;
        end
        BIT6: begin
            if (in == 1'b0)
                next_state = IDLE;
            else if (in == 1'b1)
                next_state = BIT7;
            else
                next_state = BIT6;
        end
        BIT7: begin
            if (in == 1'b1)
                next_state = BIT7;
            else
                next_state = IDLE;
        end
        default:
            next_state = IDLE;
    endcase
end

// Output logic
always @(posedge clk) begin
    if (reset) begin
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;
    end
    else begin
        case (state)
            BIT6: begin
                disc <= 1'b1;
                flag <= 1'b0;
                err <= 1'b0;
            end
            BIT7: begin
                disc <= 1'b0;
                flag <= 1'b1;
                err <= 1'b1;
            end
            default: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
        endcase
    end
end

endmodule
