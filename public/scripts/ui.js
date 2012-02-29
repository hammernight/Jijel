$(document).ready(function () {
    // site page toggling
    $('#site_features_link').click(function () {
        $('#site_features').toggle();
        $('.feature_code').hide();
    });
    $('#site_pages_link').click(function () {
        $('#site_pages').toggle();
        $('.page_code').hide();
    });
    $('#site_flows_link').click(function () {
        $('#site_flows').toggle();
        $('.flow_code').hide();
    });

    // scenario toggling
    $('a').click(function () {
        if ($(this).text() == 'Scenarios') {
            $('#scenarios_' + $(this).attr('feature')).toggle();
            if($('.feature_scenarios').is(':visible')) {
                $('#hide_scenarios_link').show();
            } else {
                hideScenarios();
            }
        }
    });

    // search text box
    $('#search_text_box').click(function () {
        if ($('#search_text_box').val() == 'Search Sites') {
            $('#search_text_box').val('')
        }
    });
    $('#search_text_box').blur(function () {
        if ($('#search_text_box').val() == '')
            $('#search_text_box').val('Search Sites')
    });

    // code syntax highlighting
    SyntaxHighlighter.all();
    $('.code_button').click(function () {
        var filename = $(this).attr('filename');
        $('#code_' + filename).slideToggle('fast', function () {
            if ($('.source_code').is(':visible')) {
                $('#hide_code_link').show();
            } else {
                hideCode();
            }
        });
    });
});

function hideCode() {
    $('.source_code').hide();
    $('#hide_code_link').hide();
}

function hideScenarios() {
    $('.feature_scenarios').hide();
    $('#hide_scenarios_link').hide();
}