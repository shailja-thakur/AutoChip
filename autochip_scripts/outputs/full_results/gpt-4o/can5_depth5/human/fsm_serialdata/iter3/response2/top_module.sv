module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE      = 3'b000,
        START     = 3'b001,
        RECEIVE   = 3'b010,
        STOP      = 3'b011,
        WAIT_STOP = 3'b100 
    } state_t;
    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shifted_byte;

    // Sequential Logic: State transitions and data shifting
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count    <= 0;
            shifted_byte <= 0;
            out_byte     <= 0;
            done         <= 0;
        end else begin
            current_state <= next_state;
            
            if (current_state == RECEIVE) begin
                shifted_byte[bit_count] <= in;
                if (bit_count == 3'd7)
                    out_byte <= {in, shifted_byte[6:0]};
                bit_count <= bit_count + 1;
            end

            if (next_state == IDLE) begin
                bit_count <= 0;
                done     <= 0;
            end else if (next_state == STOP) begin
                if (in == 1)
                    done <= 1;
                else
                    done <= 0;
            end else begin
                done <= 0;
            end
        end
    end

    // Combinational Logic: Next state and output logic
    always @(*) begin
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (in == 0)
                    next_state = START;
            end
            START: begin
                next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1)
                    next_state = IDLE;
                else
                    next_state = WAIT_STOP;
            end
            WAIT_STOP: begin
                if (in == 1)
                    next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
