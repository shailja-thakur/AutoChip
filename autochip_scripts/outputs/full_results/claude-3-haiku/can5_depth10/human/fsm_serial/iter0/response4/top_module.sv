module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define the states of the FSM
parameter IDLE = 2'b00;
parameter START = 2'b01;
parameter DATA = 2'b10;
parameter STOP = 2'b11;

reg [1:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] data_reg;

// Next state logic
always @(*)
begin
    case (state)
        IDLE:
            if (in == 1'b0)
                next_state = START;
            else
                next_state = IDLE;
        START:
            next_state = DATA;
        DATA:
            if (bit_count == 4'd8)
                next_state = STOP;
            else
                next_state = DATA;
        STOP:
            if (in == 1'b1)
                next_state = IDLE;
            else
                next_state = STOP;
        default:
            next_state = IDLE;
    endcase
end

// Output logic
always @(*)
begin
    case (state)
        IDLE:
            done = 1'b0;
        START:
            done = 1'b0;
        DATA:
            done = 1'b0;
        STOP:
            done = 1'b1;
        default:
            done = 1'b0;
    endcase
end

// State register
always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Bit counter and data register
always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
        bit_count <= 4'b0000;
        data_reg <= 8'b0;
    end
    else
    begin
        case (state)
            IDLE:
            begin
                bit_count <= 4'b0000;
                data_reg <= 8'b0;
            end
            START:
                bit_count <= 4'b0001;
            DATA:
            begin
                bit_count <= bit_count + 4'b0001;
                data_reg <= {data_reg[6:0], in};
            end
            STOP:
            begin
                bit_count <= 4'b0000;
                data_reg <= 8'b0;
            end
            default:
            begin
                bit_count <= 4'b0000;
                data_reg <= 8'b0;
            end
        endcase
    end
end

endmodule
