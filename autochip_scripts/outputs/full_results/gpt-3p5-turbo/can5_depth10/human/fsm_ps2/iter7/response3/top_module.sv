module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [2:0] state;
    reg [7:0] byte_count;
    reg last_byte_in;
    wire start_of_message;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initial state
            byte_count <= 8'd0;
            last_byte_in <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                3'b000: begin // Waiting for start of message
                    if (in[3]) begin
                        state <= 3'b001; // First byte received
                        byte_count <= 8'd1;
                    end
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
                    if (in[3]) begin // Start of next message
                        state <= 3'b001;
                        byte_count <= 8'd1;
                    end else begin
                        state <= 3'b000;
                    end
                end
            endcase
            
            last_byte_in <= in[3];
            
            if (byte_count == 8'd2 && state == 3'b010) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end
    
    assign start_of_message = (state == 3'b000) && (in[3]);
    
endmodule
