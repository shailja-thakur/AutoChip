module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // Insert your code below
    
    // FSM from fsm_ps2

    // New: Datapath to store incoming bytes.
    reg [7:0] byte_1;
    reg [7:0] byte_2;
    reg [7:0] byte_3;

    // State machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            switch (state) begin
            case IDLE:
                if (in[3] == 1) begin
                    state <= RECEIVE_BYTE_1;
                end
            case RECEIVE_BYTE_1:
                if (in[3] == 0) begin
                    state <= RECEIVE_BYTE_2;
                end
            case RECEIVE_BYTE_2:
                if (in[3] == 0) begin
                    state <= RECEIVE_BYTE_3;
                end
            case RECEIVE_BYTE_3:
                if (in[3] == 0) begin
                    state <= DONE;
                end
            endcase
        end
    end

    // Datapath
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            byte_1 <= 8'h0;
            byte_2 <= 8'h0;
            byte_3 <= 8'h0;
        end else begin
            switch (state) begin
            case IDLE:
                // Do nothing
            case RECEIVE_BYTE_1:
                byte_1 <= in;
            case RECEIVE_BYTE_2:
                byte_2 <= in;
            case RECEIVE_BYTE_3:
                byte_3 <= in;
            case DONE:
                out_bytes <= byte_1 << 16 | byte_2 << 8 | byte_3;
            endcase
        end
    end

endmodule