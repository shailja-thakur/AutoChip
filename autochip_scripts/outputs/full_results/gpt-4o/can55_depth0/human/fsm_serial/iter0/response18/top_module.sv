module top_module (
    input clk,
    input in,
    input reset,
    output done
);
    
    reg [3:0] state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_byte;
    
    localparam IDLE = 4'd0,
               START = 4'd1,
               DATA = 4'd2,
               STOP = 4'd3,
               DONE = 4'd4;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'd0;
            data_byte <= 8'd0;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case(state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
                else
                    next_state = IDLE;
            end
            
            START: begin
                if (bit_counter == 3'd7) // Received all 8 data bits
                    next_state = DATA;
                else
                    next_state = START;
            end
            
            DATA: begin
                if (bit_counter == 3'd7) begin
                    if (in == 1'b1) // Stop bit detected
                        next_state = DONE;
                    else
                        next_state = STOP;
                end else
                    next_state = DATA;
            end
            
            STOP: begin
                if (in == 1'b1) // Wait for stop bit
                    next_state = IDLE;
                else
                    next_state = STOP;
            end
            
            DONE: begin
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if (state == START) begin
            bit_counter <= bit_counter + 3'd1;
            data_byte <= {in, data_byte[7:1]};
        end else if (state == DATA) begin
            bit_counter <= bit_counter + 3'd1;
            data_byte <= {in, data_byte[7:1]};
        end else if (state == IDLE) begin
            bit_counter <= 3'd0;
            data_byte <= 8'd0;
        end
    end
    
    assign done = (state == DONE);

endmodule
