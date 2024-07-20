module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states of the FSM
localparam [2:0] 
    IDLE = 3'b000,
    START = 3'b001,
    DATA = 3'b010,
    STOP = 3'b011,
    ERROR = 3'b100;

reg [2:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] shift_reg;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b0) begin
                next_state = START;
            end
            else begin
                next_state = IDLE;
            end
        end
        START: begin
            if (in == 1'b0) begin
                next_state = DATA;
            end
            else begin
                next_state = ERROR;
            end
        end
        DATA: begin
            if (bit_count == 4'd8) begin
                next_state = STOP;
            end
            else begin
                next_state = DATA;
            end
        end
        STOP: begin
            if (in == 1'b1) begin
                next_state = IDLE;
            end
            else begin
                next_state = ERROR;
            end
        end
        ERROR: begin
            if (in == 1'b1) begin
                next_state = IDLE;
            end
            else begin
                next_state = ERROR;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        out_byte <= 8'b0;
        done <= 1'b0;
        bit_count <= 4'b0;
        shift_reg <= 8'b0;
    end
    else begin
        case (state)
            IDLE: begin
                out_byte <= 8'b0;
                done <= 1'b0;
                bit_count <= 4'b0;
                shift_reg <= 8'b0;
            end
            START: begin
                // Do nothing
            end
            DATA: begin
                shift_reg[7:0] <= {shift_reg[6:0], in};
                bit_count <= bit_count + 1;
            end
            STOP: begin
                out_byte <= shift_reg;
                done <= 1'b1;
                bit_count <= 4'b0;
                shift_reg <= 8'b0;
            end
            ERROR: begin
                out_byte <= 8'b0;
                done <= 1'b0;
                bit_count <= 4'b0;
                shift_reg <= 8'b0;
            end
            default: begin
                // Do nothing
            end
        endcase
    end
end

endmodule
