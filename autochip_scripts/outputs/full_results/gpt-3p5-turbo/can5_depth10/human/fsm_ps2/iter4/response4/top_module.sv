module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [2:0] state;
    reg [2:0] next_state;
    reg [7:0] byte_count;
    wire start_of_message;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initial state
            byte_count <= 8'd0;
        end else begin
            state <= next_state;
            case (state)
                3'b000: begin // Waiting for start of message
                    if (in[3]) begin
                        next_state <= 3'b001; // First byte received
                        byte_count <= 8'd1;
                    end
                end
                3'b001: begin // Receiving second byte
                    next_state <= 3'b010;
                end
                3'b010: begin // Receiving third byte
                    next_state <= 3'b011; // Message received
                end
                3'b011: begin // Message received, wait for next start
                    next_state <= 3'b000; // Waiting for start of next message
                    byte_count <= 8'd0;
                end
            endcase
            if (in[3] && state != 3'b011) begin
                byte_count <= byte_count + 1;
            end
        end
    end
    
    assign start_of_message = state == 3'b000 && in[3];
    assign done = state == 3'b010 && byte_count == 8'd3;
    
endmodule
