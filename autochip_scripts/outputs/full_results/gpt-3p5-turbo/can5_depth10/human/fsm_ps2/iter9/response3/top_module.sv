module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [2:0] state;
    reg [7:0] byte_count;
    reg last_byte_in;
    reg start_of_message;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; 
            byte_count <= 8'd0;
            last_byte_in <= 1'b0;
            done <= 1'b0;
            start_of_message <= 1'b0;
        end else begin
            case (state)
                3'b000: begin 
                    state <= in[3] ? 3'b001 : 3'b000;
                    byte_count <= in[3] ? 8'd1 : 8'd0;
                    start_of_message <= in[3] ? 1'b1 : 1'b0; // Update start_of_message here
                end
                3'b001: begin 
                    state <= 3'b010;
                    byte_count <= byte_count + 1;
                    start_of_message <= 1'b0; // Reset start_of_message
                end
                3'b010: begin 
                    state <= 3'b011; 
                    byte_count <= byte_count + 1;
                    start_of_message <= 1'b0; // Reset start_of_message
                end
                3'b011: begin 
                    state <= in[3] ? 3'b001 : 3'b000;
                    byte_count <= in[3] ? 8'd1 : 8'd0;
                    start_of_message <= in[3] ? 1'b1 : 1'b0; // Update start_of_message here
                end
            endcase
            
            last_byte_in <= in[3];
            
            if (byte_count == 8'd2 && state == 3'b011) begin // Check for state 3'b011
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end
    
endmodule
