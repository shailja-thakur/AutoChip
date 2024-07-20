module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;

reg [7:0] received_byte;
reg [2:0] bit_counter;

/* State definitions */
localparam START_BIT = 3'b000;
localparam DATA_BIT = 3'b001;
localparam STOP_BIT = 3'b010;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= START_BIT;
        received_byte <= 8'b0;
        bit_counter <= 3'b0;
        done <= 0;
    end else begin
        case (state)
            START_BIT: begin
                if (in == 1'b0) begin
                    state <= DATA_BIT;
                    bit_counter <= 3'b0;
                end
            end
            
            DATA_BIT: begin
                if (bit_counter == 3'b111) begin
                    state <= STOP_BIT;
                    bit_counter <= 3'b0;
                end else begin
                    received_byte <= {received_byte[6:0], in};
                    bit_counter <= bit_counter + 1;
                end
            end
            
            STOP_BIT: begin
                if (bit_counter == 3'b000 && in == 1'b1) begin
                    state <= START_BIT;
                    done <= 1;
                end else if (in == 1'b0) begin
                    state <= DATA_BIT;
                    received_byte <= 8'b0;
                    bit_counter <= 3'b0;
                end
            end
        endcase
    end
end

assign out_byte = received_byte;

endmodule
