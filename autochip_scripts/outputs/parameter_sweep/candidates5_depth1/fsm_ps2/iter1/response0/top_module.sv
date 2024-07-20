module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    reg [2:0] state;
    reg [2:0] next_state;
    reg [1:0] byte_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            byte_count <= 2'b00;
        end else begin
            state <= next_state;
            byte_count <= byte_count + 1;
        end
    end

    always @* begin
        case (state)
            3'b000: begin // Find first byte of message
                if (in[3] == 1'b1) begin
                    next_state = 3'b001;
                end else begin
                    next_state = 3'b000;
                end
            end
            3'b001: begin // Receive second byte of message
                next_state = 3'b010;
            end
            3'b010: begin // Receive third byte of message
                next_state = 3'b011;
            end
            3'b011: begin // Wait one cycle after third byte to signal done
                next_state = 3'b000;
            end
            default: begin
                next_state = 3'b000;
            end
        endcase
    end

    assign done = (state == 3'b011);

    // Reset byte_count when new message starts
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            byte_count <= 2'b00;
        end else if (state == 3'b000 && next_state == 3'b001) begin
            byte_count <= 2'b00;
        end else if (byte_count == 2'b10 && next_state != 3'b000) begin
            byte_count <= 2'b00;
        end
        else if (byte_count == 2'b11) begin
            byte_count <= 2'b00;
        end else begin
            byte_count <= byte_count + 1;
        end
    end

    // State transition logic modification
    always @* begin
        if (state == 3'b000 && next_state == 3'b001) begin
            if (byte_count != 2'b10) begin
                next_state = 3'b000;
            end
        end
        
        if (state == 3'b001 && next_state == 3'b010) begin
            if (byte_count != 2'b01) begin
                next_state = 3'b000;
            end
        end
    end

endmodule
