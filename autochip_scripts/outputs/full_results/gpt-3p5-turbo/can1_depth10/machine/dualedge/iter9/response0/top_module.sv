module top_module(
    input clk,
    input d,
    output reg q);

    // Adding a wire to hold the synchronized value
    wire [1:0] sync_val;

    // Using a clock edge detection module to generate positive and negative edge pulses
    clock_edge_detection u1(.clk(clk), .posedge_pulse, .negedge_pulse);

    always @(posedge clk) begin
        qp <= d;
    end

    always @(negedge clk) begin
        qn <= d;
    end

    always @(posedge clk) begin
        if (posedge_pulse) begin
            sync_val <= qp;
        end else begin
            sync_val <= qn;
        end
    end

    always @(posedge clk) begin
        q <= sync_val;
    end

endmodule
module clock_edge_detection(
    input clk,
    output reg posedge_pulse,
    output reg negedge_pulse
    );

    reg prev_clk;

    always @(posedge clk or negedge clk) begin
        posedge_pulse <= (clk && ~prev_clk);
        negedge_pulse <= (~clk && prev_clk);
        prev_clk <= clk;
    end
    
endmodule
