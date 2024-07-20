module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    
    reg [23:0] message; // Stores the received message
    reg [1:0] state; // Finite state machine state
    reg [2:0] counter; // Counter for tracking the received byte position
    wire byte1; // Signal indicating the first byte of the message
    wire byte2; // Signal indicating the second byte of the message
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            message <= 24'b0;
            counter <= 3'b000;
        end
        else begin
            case (state)
                2'b00: begin // Initial state
                    if (in[3]) begin // Byte with in[3]=1, assume it's the first byte
                        state <= 2'b01; // Transition to state 01
                        message <= {16'b0, in};
                        counter <= 3'b001;
                    end
                end
                2'b01: begin // Receiving bytes
                    if (byte1) begin // If it's byte 1 of the message
                        state <= 2'b01;
                        message <= {in, message[23:8]};
                        counter <= counter + 1;
                    end
                    else if (byte2) begin // If it's byte 2 of the message
                        state <= 2'b10;
                    end
                end
                2'b10: begin // Message complete
                    state <= 2'b00;
                    counter <= 3'b000;
                end
            endcase
        end
    end

    assign byte1 = (state == 2'b01 && counter == 3'b001);
    assign byte2 = (state == 2'b01 && counter == 3'b010);

    always @(posedge clk) begin
        if (state == 2'b10 && counter == 3'b000) begin // Message complete
            out_bytes <= message;
            done <= 1'b1;
        end
        else begin
            out_bytes <= 24'b0;
            done <= 1'b0;
        end
    end
endmodule
