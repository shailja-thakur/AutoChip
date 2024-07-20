module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] previous_byte;
reg [7:0] current_byte;
reg [1:0] state;

parameter IDLE = 2'b00;
parameter SEARCHING = 2'b01;
parameter RECEIVING = 2'b10;

always @(posedge clk)
begin
    if (reset)
    begin
        state <= IDLE;
    end
    else
    begin
        case (state)
            IDLE:
                if (in[3] == 1'b1)
                begin
                    previous_byte <= in;
                    state <= SEARCHING;
                end

            SEARCHING:
                if (in[3] == 1'b1)
                begin
                    previous_byte <= in;
                    state <= RECEIVING;
                end
                else
                begin
                    previous_byte <= 8'b0;
                end

            RECEIVING:
                if (in[3] == 1'b0)
                begin
                    state <= SEARCHING;
                end
                else
                begin
                    current_byte <= in;
                    if (previous_byte[3] == 1'b1 && current_byte[3] == 1'b1)
                    begin
                        state <= IDLE;
                        done <= 1'b1;
                    end
                    else
                    begin
                        previous_byte <= current_byte;
                    end
                end
        endcase
    end
end

endmodule
