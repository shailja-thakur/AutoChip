module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    // Internal signals
    reg [23:0] message;
    reg [1:0] state;
    reg [2:0] counter;
    reg sync_reset;
    wire search_byte_found;

    // State definitions
    parameter IDLE = 2'b00;
    parameter SEARCH = 2'b01;
    parameter DONE = 2'b10;

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            message <= 0;
            counter <= 0;
            sync_reset <= 1;
        end
        else begin
            case (state)
                IDLE: begin
                    if (in[3]) begin
                        state <= SEARCH;
                        message <= {in, message[23:8]};
                        counter <= 1;
                    end
                end
                SEARCH: begin
                    if (in[3]) begin
                        if (counter == 1) begin
                            state <= DONE;
                        end
                        else begin
                            state <= SEARCH;
                        end
                        message <= {in, message[23:8]};
                        counter <= counter + 1;
                    end
                    else begin
                        state <= IDLE;
                        message <= 0;
                        counter <= 0;
                        sync_reset <= 1;
                    end
                end
                DONE: begin
                    state <= IDLE;
                    counter <= 0;
                    sync_reset <= 0;
                end
                default: begin
                    state <= IDLE;
                    counter <= 0;
                    sync_reset <= 1;
                end
            endcase
        end
    end

    // Check if search byte is found
    assign search_byte_found = (state == SEARCH && in[3]);

    // Combinational logic
    always @* begin
        if (search_byte_found) begin
            out_bytes[23:16] <= message[23:16];
            out_bytes[15:8] <= message[15:8];
            out_bytes[7:0] <= message[7:0];
        end
    end
    
    assign done = (state == DONE);

    // Synchronous reset
    always @(posedge clk) begin
        if (sync_reset) begin
            sync_reset <= 0;
        end
    end
endmodule
