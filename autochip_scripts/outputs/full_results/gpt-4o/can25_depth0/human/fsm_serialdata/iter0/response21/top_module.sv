module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] data_register;
    reg [3:0] bit_counter;
    
    localparam IDLE     = 4'd0,
               START    = 4'd1,
               RECEIVE  = 4'd2,
               STOP     = 4'd3,
               FRAMING_ERROR = 4'd4;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'b0;
            done <= 0;
            bit_counter <= 4'd0;
            data_register <= 8'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @* begin
        next_state = state;
        done = 0;
        
        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
                bit_counter = 4'd0;
            end
            
            START: begin
                if (bit_counter == 4'd1) begin
                    next_state = RECEIVE;
                    bit_counter = 4'd0;
                end else
                    bit_counter = bit_counter + 1;
            end
            
            RECEIVE: begin
                data_register[bit_counter] = in;
                if (bit_counter == 4'd7) begin
                    next_state = STOP;
                    bit_counter = 4'd0;
                end else
                    bit_counter = bit_counter + 1;
            end
            
            STOP: begin
                if (in == 1'b1) begin
                    out_byte = data_register;
                    done = 1;
                    next_state = IDLE;
                end else
                    next_state = FRAMING_ERROR;
            end
            
            FRAMING_ERROR: begin
                if (in == 1'b1) begin // Wait for a stop bit to resume
                    next_state = IDLE;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule
