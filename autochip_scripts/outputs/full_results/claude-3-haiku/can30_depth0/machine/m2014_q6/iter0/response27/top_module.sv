module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states
localparam [2:0] 
    A = 3'd0,
    B = 3'd1,
    C = 3'd2,
    D = 3'd3,
    E = 3'd4,
    F = 3'd5;

// Define the current state register
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        // Reset the state to A
        state <= A;
    end
    else begin
        // Update the state based on the current state and the input w
        case (state)
            A: begin
                if (w) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            B: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= C;
                end
            end
            C: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= E;
                end
            end
            D: begin
                if (w) begin
                    state <= A;
                end
                else begin
                    state <= F;
                end
            end
            E: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= E;
                end
            end
            F: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= C;
                end
            end
        endcase
    end
end

// Set the output z based on the current state
always @(*) begin
    case (state)
        E, F: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
