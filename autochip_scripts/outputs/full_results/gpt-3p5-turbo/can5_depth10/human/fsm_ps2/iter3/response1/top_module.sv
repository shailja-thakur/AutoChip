module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    
    reg [1:0] state;
    reg [7:0] byte_count;
    wire start_of_message;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // Initial state
            byte_count <= 8'd0;
        end else begin
            case (state)
                2'b00: begin // Waiting for start of message
                    if (in[3]) begin
                        state <= 2'b01; // First byte received
                        byte_count <= 8'd1;
                    end
                end
                2'b01: begin // Receiving second byte
                    state <= 2'b10;
                end
                2'b10: begin // Receiving third byte
                    state <= 2'b11; // Message received
                end
                2'b11: begin // Message received, wait for next start
                    if (in[3]) begin
                        state <= 2'b00; // Waiting for start of next message
                        byte_count <= 8'd0;
                    end
                end
            endcase
            if (state == 2'b10) begin
                byte_count <= byte_count + 1;
            end
        end
    end
    
    assign start_of_message = (state == 2'b00) && (in[3] == 1);
    assign done = (state == 2'b10) && (byte_count == 8'd2);
    
endmodule
