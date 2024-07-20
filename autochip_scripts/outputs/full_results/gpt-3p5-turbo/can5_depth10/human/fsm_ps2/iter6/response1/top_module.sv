module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [2:0] state;
    reg [7:0] byte_count;
    reg start_of_message;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initial state
            byte_count <= 8'd0;
            start_of_message <= 1'b0;
        end else if (state == 3'b000) begin
            if (in[3]) begin
                state <= 3'b001; // First byte received
                byte_count <= 8'd1;
                start_of_message <= 1'b1;
            end
        end else begin
            case (state)
                3'b001: begin // Receiving second byte
                    state <= 3'b010;
                end
                3'b010: begin // Receiving third byte
                    state <= 3'b011; // Message received
                end
                3'b011: begin // Message received, wait for next start
                    state <= 3'b000; // Waiting for start of next message
                    byte_count <= 8'd0;
                    start_of_message <= 1'b0;
                end
            endcase
            if (in[3]) begin
                byte_count <= byte_count + 1;
                if (byte_count == 8'd2) begin
                    state <= 3'b011;
                end
            end
        end
    end
    
    assign done = (state == 3'b011) && (byte_count == 8'd2);
    
    // Testbench will assign values to in, reset, and clk
    
endmodule
