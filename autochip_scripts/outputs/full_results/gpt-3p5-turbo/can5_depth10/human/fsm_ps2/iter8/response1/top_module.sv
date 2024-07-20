module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [2:0] state;
    reg [7:0] byte_count;
    reg last_byte_in;
    reg start_of_message; // Added reg for start_of_message
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initial state
            byte_count <= 8'd0;
            last_byte_in <= 1'b0;
            done <= 1'b0;
            start_of_message <= 1'b0; // Initialize start_of_message
        end else begin
            case (state)
                3'b000: begin // Waiting for start of message
                    state <= in[3] ? 3'b001 : 3'b000; // Check if start of message
                    byte_count <= in[3] ? 8'd1 : 8'd0; // Increment byte count if start of message
                end
                3'b001: begin // Receiving second byte
                    state <= 3'b010;
                    byte_count <= byte_count + 1;
                end
                3'b010: begin // Receiving third byte
                    state <= 3'b011; // Message received
                    byte_count <= byte_count + 1;
                end
                3'b011: begin // Message received, wait for next start
                    state <= in[3] ? 3'b001 : 3'b000; // Check if start of next message
                    byte_count <= in[3] ? 8'd1 : 8'd0; // Increment byte count if start of message
                end
            endcase
            
            last_byte_in <= in[3];
            
            if (byte_count == 8'd2 && state == 3'b010) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
            
            if (state == 3'b000) begin // Update start_of_message in every clock cycle
                start_of_message <= in[3];
            end
        end
    end
    
endmodule
