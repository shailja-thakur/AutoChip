module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [2:0] state;
    reg [7:0] byte_count;
    reg last_byte_in;
    reg last_last_byte_in; // Added register to store the previous byte
    reg start_of_message;
    reg next_message_start; // Added register to indicate the start of next message
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initial state
            byte_count <= 8'd0;
            last_byte_in <= 1'b0;
            last_last_byte_in <= 1'b0; // Initialize register
            done <= 1'b0;
            start_of_message <= 1'b0;
            next_message_start <= 1'b0; // Initialize register
        end else begin
            last_last_byte_in <= last_byte_in; // Store previous byte
            last_byte_in <= in[3];
            
            case (state)
                3'b000: begin // Waiting for start of message
                    if (last_byte_in) begin
                        state <= 3'b001;
                        byte_count <= 8'd1;
                        start_of_message <= 1'b1; // Indicate start of message
                    end else begin
                        state <= 3'b000;
                        byte_count <= 8'd0;
                        start_of_message <= 1'b0;
                    end
                end
                3'b001: begin // Receiving second byte
                    state <= 3'b010;
                    byte_count <= byte_count + 1;
                    start_of_message <= 1'b0;
                end
                3'b010: begin // Receiving third byte
                    state <= 3'b011; // Message received
                    byte_count <= byte_count + 1;
                    start_of_message <= 1'b0;
                end
                3'b011: begin // Message received, wait for next start
                    if (last_last_byte_in && last_byte_in) begin
                        state <= 3'b001;
                        byte_count <= 8'd1;
                        start_of_message <= 1'b1; // Indicate start of next message
                    end else begin
                        state <= 3'b000;
                        byte_count <= 8'd0;
                        start_of_message <= 1'b0;
                    end
                end
            endcase
            
            if (byte_count == 8'd2 && state == 3'b010) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end
    
endmodule
