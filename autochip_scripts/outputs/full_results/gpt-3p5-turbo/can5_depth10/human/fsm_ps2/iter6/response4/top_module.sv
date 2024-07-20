module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [2:0] state;
    reg [7:0] byte_count;
    wire start_of_message;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // Initial state
            byte_count <= 8'd0;
            done <= 1'b0;
        end else begin
            case (state)
                3'b000: begin // Waiting for start
                    if (in[3]) begin
                        byte_count <= 8'd1;
                        state <= 3'b001; // Receiving first byte
                    end
                end
                3'b001: begin // Receiving second byte
                    byte_count <= 8'd2;
                    state <= 3'b010;
                end
                3'b010: begin // Receiving third byte
                    state <= 3'b000; // Waiting for next start
                    done <= 1'b1; // Message received
                end
            endcase
        end
    end
    
    assign start_of_message = (state == 3'b000) && (in[3]);
    
endmodule
