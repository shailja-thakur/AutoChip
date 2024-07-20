module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// Declare state parameter
localparam [1:0] BYTE1 = 2'b00;
localparam [1:0] BYTE2 = 2'b01;
localparam [1:0] BYTE3 = 2'b10;
localparam [1:0] DONE = 2'b11;

// Declare state register
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1; // Initialize state to BYTE1 on reset
    end else begin
        case(state)
            BYTE1: begin
                if (in[2] == 1) begin
                    state <= BYTE2;
                end
            end
            BYTE2: begin
                state <= BYTE3;
            end
            BYTE3: begin
                state <= DONE;
            end
        endcase
        
        if (state == DONE && in[2] == 0) begin
            state <= BYTE1;
        end else if (state == DONE && in[2] == 1) begin
            state <= BYTE2;
        end
    end
end

assign done = (state == DONE);

endmodule
